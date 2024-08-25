$Env:PIP_INDEX_URL = "https://pypi.mirrors.ustc.edu.cn/simple"
$Env:HF_ENDPOINT = "https://hf-mirror.com"

Set-Location $PSScriptRoot

if (!(Test-Path -Path "venv")) {
    Write-Output  "Creating venv for python..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "Installing torch+cuda"
pip install torch==2.3.1+cu121 torchvision==0.18.1+cu121 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html

Write-Output "Installing deps..."
pip install --upgrade -r requirements.txt

Write-Output "Searching segment model..."
$url="https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth"

$dest="./segment_model/sam_vit_h_4b8939.pth"

if (!(Test-Path -Path $dest)) {
    Write-Output  "Downloading segment model to ./segment_model/sam_vit_h_4b8939.pth"
    Write-Output  "or you can close now and download it form https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth by yourself"
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($url, $dest)
}

Write-Output "Install completed"
Read-Host | Out-Null ;