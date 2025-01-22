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

i = 0
last_image = "molecule55.jpeg"
#last_image = os.path.basename(os.getcwd())  + str(i) + ".jpeg"

story = []
# d: duration (frame), st: strengh, gs: guidance scale, ni: num_inference_steps, p : prompt
story.append({"d": 15*10, "st" : 0.5, "gs": 5.5, "ni":100, "p": "aborigins style painting"})
story.append({"d": 15*10, "st" : 0.5, "gs": 5.5, "ni":100, "p": "electronic circuits"})
story.append({"d": 15*10, "st" : 0.5, "gs": 5.5, "ni":100, "p": "planets, stars"})
story.append({"d": 15*10, "st" : 0.5, "gs": 5.5, "ni":100, "p": "lezards, jungle"})
story.append({"d": 15*10, "st" : 0.5, "gs": 5.5, "ni":100, "p": "psychedelic molecules"})
story.append({"d": 15*10, "st" : 0.5, "gs": 5.5, "ni":100, "p": "insects"})

total_dur = sum(item["d"] for item in story)
print ('total_dur: ' + str (total_dur) )
print ('len story: ' + str (len(story)) )
print(str(100 % total_dur))
# story index
j = 0
# cumulated dur in story
cd = story[0]["d"]

i= i +1
while True :
  print ('i:' + str(i) + ' ,j:' + str(j) + " , i % total_dur ", str(  i % total_dur ) )
  if ( i % total_dur ) > cd or  ( i % total_dur ) == 0:
    j = (j + 1) % len(story)
    print("new prompt:" + story[j]["p"] + ", strength:" + str (story[j]["st"]) +  ", guidance_scale:" + str (story[j]["gs"]) +", num_inference_steps:" + str (story[j]["ni"]) + ", j:" + str(j) )
    if j == 0 :
      cd = story[0]["d"]
      print("Restart story cd:" + str(cd))
    else : 
      cd = cd + story[j]["d"]
      print("cd:" + str(cd))

  init_image = Image.open(last_image).convert("RGB")
  images = pipe(prompt=story[j]["p"], image=init_image, strength=story[j]["st"], guidance_scale=story[j]["gs"], num_inference_steps=story[j]["ni"]).images
  last_image = os.path.basename(os.getcwd())  + str(i) + ".jpeg"
  images[0].save(last_image )
  i = i + 1
