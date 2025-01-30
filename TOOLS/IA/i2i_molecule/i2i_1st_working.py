# https://huggingface.co/docs/diffusers/api/pipelines/stable_diffusion/img2img

import requests

import torch

from PIL import Image

from io import BytesIO

from diffusers import StableDiffusionImg2ImgPipeline

import os

print( os.path.basename(os.getcwd()))


#model_id_or_path = "stabilityai/stable-diffusion-2-1"
model_id_or_path = "runwayml/stable-diffusion-v1-5"

pipe = StableDiffusionImg2ImgPipeline.from_pretrained(model_id_or_path, torch_dtype=torch.float32)

url = "https://raw.githubusercontent.com/CompVis/stable-diffusion/main/assets/stable-samples/img2img/sketch-mountains-input.jpg"
response = requests.get(url)
init_image = Image.open(BytesIO(response.content)).convert("RGB")
init_image = init_image.resize((768, 512))
#init_image = Image.open(BytesIO("molecule73.jpeg")).convert("RGB")
#init_image = Image.open("molecule73.jpeg").convert("RGB")

prompt = "psychedelic molecules, laser rays and fractals"
i=0
while True :
  images = pipe(prompt=prompt, image=init_image, strength=0.75, guidance_scale=7.5).images
  images[0].save("i2i_" + os.path.basename(os.getcwd()  + str(i) + ".jpeg"))
  i = i + 1
