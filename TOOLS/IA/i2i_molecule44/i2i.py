# https://huggingface.co/docs/diffusers/api/pipelines/stable_diffusion/img2img
# ffmpeg -framerate 10 -i filename-%03d.png output.mp4

import requests

import torch

from PIL import Image

from io import BytesIO

from diffusers import StableDiffusionImg2ImgPipeline

import os

print( os.path.basename(os.getcwd()))


model_id_or_path = "stabilityai/stable-diffusion-2-1"
#model_id_or_path = "runwayml/stable-diffusion-v1-5"

device = "cuda"

pipe = StableDiffusionImg2ImgPipeline.from_pretrained(model_id_or_path, torch_dtype=torch.float16)
pipe = pipe.to(device)

#url = "https://raw.githubusercontent.com/CompVis/stable-diffusion/main/assets/stable-samples/img2img/sketch-mountains-input.jpg"
#response = requests.get(url)
#init_image = Image.open(BytesIO(response.content)).convert("RGB")
#init_image = init_image.resize((768, 512))

#init_image = Image.open(BytesIO("molecule73.jpeg")).convert("RGB")
last_image = "molecule44.jpeg"

prompt = "psychedelic molecules, centered, add eyes and details, avoid uniform areas, put some stars on the sides"

i=0
while True :
  init_image = Image.open(last_image).convert("RGB")
  images = pipe(prompt=prompt, image=init_image, strength=0.5, guidance_scale=7.5).images
  last_image = os.path.basename(os.getcwd())  + str(i) + ".jpeg"
  images[0].save(last_image )
  i = i + 1
