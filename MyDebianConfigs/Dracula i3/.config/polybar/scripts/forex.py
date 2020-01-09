import tabula
from selenium import webdriver

url = 'https://v1.hdfcbank.com/assets/pdf/forex_rates/rates.pdf'

download_dir = "" # for linux/*nix, download_dir="/usr/Public"
options = webdriver.ChromeOptions()
options.add_experimental_option('prefs', {
"download.default_directory": download_dir, #Change default directory for downloads
"download.prompt_for_download": False, #To auto download the file
"download.directory_upgrade": True,
"plugins.always_open_pdf_externally": True #It will not show PDF directly in chrome
})
options.add_argument('--headless')
driver = webdriver.Chrome(chrome_options=options)  # Optional argument, if not specified will search path.
driver.get(url)
df = tabula.read_pdf(download_dir+'rates.pdf')
print(df.iloc[20,9])
