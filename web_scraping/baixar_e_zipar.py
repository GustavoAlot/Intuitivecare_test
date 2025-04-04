import requests
from bs4 import BeautifulSoup
import os
import zipfile

def compactar_pdfs_em_zip(pasta, arquivos, destino_zip):
    with zipfile.ZipFile(destino_zip, 'w') as zipf:
        for nome_arquivo in arquivos:
            caminho_arquivo = os.path.join(pasta, nome_arquivo)
            zipf.write(caminho_arquivo, arcname=nome_arquivo)
    print(f"Arquivos compactados com sucesso em: {destino_zip}")


def download_pdf_from_page(url, anexo_text, save_path):
    response = requests.get(url)
    if response.status_code != 200:
        print("Erro ao acessar a página:", response.status_code)
        return

    soup = BeautifulSoup(response.text, 'html.parser')
    # Procura por uma tag <a> que contenha o texto do anexo
    link_tag = soup.find('a', string=lambda text: text and anexo_text in text)
    if not link_tag:
        print(f"Não encontrou o link para {anexo_text}")
        return

    pdf_url = link_tag.get('href')
    # Se o link for relativo, ajusta para o URL absoluto
    if pdf_url.startswith('/'):
        pdf_url = 'https://www.gov.br' + pdf_url

    pdf_response = requests.get(pdf_url, allow_redirects=True)
    if pdf_response.status_code == 200:
        with open(save_path, 'wb') as f:
            f.write(pdf_response.content)
        print(f"{anexo_text} baixado com sucesso em {save_path}")
    else:
        print(f"Erro ao baixar {anexo_text}. Status Code: {pdf_response.status_code}")

if __name__ == '__main__':
    url_page = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
    os.makedirs('downloads', exist_ok=True)
    download_pdf_from_page(url_page, "Anexo I", os.path.join('downloads', 'Anexo_I.pdf'))
    download_pdf_from_page(url_page, "Anexo II", os.path.join('downloads', 'Anexo_II.pdf'))


    arquivos_para_zipar = ['Anexo_I.pdf', 'Anexo_II.pdf']
    destino_do_zip = 'pdfs.zip'

    os.makedirs('web_scraping', exist_ok=True)
    compactar_pdfs_em_zip('downloads', arquivos_para_zipar, destino_do_zip)
