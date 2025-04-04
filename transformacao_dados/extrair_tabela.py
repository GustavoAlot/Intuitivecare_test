import pdfplumber
import pandas as pd
import os
import zipfile

def extrair_tabela_pdf(pdf_path):
    all_rows = []
    header = None
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            tabela = page.extract_table()
            if tabela:
                # se for a primeira paginad assume a primeira linha como cabecalho
                if header is None:
                    header = tabela[0]
                    all_rows.extend(tabela[1:])  # add as linhas restantes
                else:
                    # Se a primeira linha da pagina atual for igual ao cabecalho, joga fora
                    if tabela[0] == header:
                        all_rows.extend(tabela[1:])
                    else:
                        all_rows.extend(tabela)
    return header, all_rows

def salvar_csv(header, rows, csv_output):
    df = pd.DataFrame(rows, columns=header)
    df.to_csv(csv_output, index=False)
    print(f'CSV salvo em {csv_output}')
    return df

def aplicar_substituicoes(df, substituicoes_csv):
    subs = pd.read_csv(substituicoes_csv, header=None)
    mapping = dict(zip(subs.iloc[:, 0].str.strip(), subs.iloc[:, 1].str.strip()))
    # Se a disgrama do OD nao estiver no mapping, adiciona manualmente
    if "OD" not in mapping:
        mapping["OD"] = "Seg. Odontológica"
    # Limpa os nomes das colunas e aplica a substituicao
    colunas_originais = df.columns.tolist()
    colunas_novas = []
    for col in colunas_originais:
        col_limpo = col.strip()
        if col_limpo in mapping:
            colunas_novas.append(mapping[col_limpo])
        else:
            colunas_novas.append(col)
    df.columns = colunas_novas
    print("\n✔️ Substituições aplicadas:")
    print("Antes :", colunas_originais)
    print("Depois:", df.columns.tolist())
    return df






def compactar_csv(csv_file, zip_output):
    with zipfile.ZipFile(zip_output, 'w') as zipf:
        zipf.write(csv_file, arcname=os.path.basename(csv_file))
    print(f'CSV compactado em {zip_output}')

if __name__ == '__main__':
    # defininco caminhhos
    pdf_path = '../web_scraping/downloads/Anexo_I.pdf'  
    csv_output = 'tabela_extraida.csv'
    substituicoes_csv = 'substituicoes.csv'
    zip_output = 'Teste_Gustavo_Fernandez.zip'
    
    
    
    # pegando dados do do PDF
    header, rows = extrair_tabela_pdf(pdf_path)
    if header is None or not rows:
        print("Nenhuma tabela encontrada no PDF.")
    else:
        # Salva os dados extraidos em CSV
        df = salvar_csv(header, rows, csv_output)
        # Aplica as substituicoes de coluna 
        df = aplicar_substituicoes(df, substituicoes_csv)
        # Salva novamente para atualizar o CSV com as colunas renomeadas
        df.to_csv(csv_output, index=False)
        # Compacta o CSV em um arquivo .zip
        compactar_csv(csv_output, zip_output)
