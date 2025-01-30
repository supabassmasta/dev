from diffusers import DiffusionPipeline


pipeline = DiffusionPipeline.from_pretrained("runwayml/stable-diffusion-v1-5", use_safetensors=True)
i = 0
while True:

    image = pipeline("psychedelic cyberpunk owl dancing centered realistic photo quality").images[0]
    image.save("owl_" + str(i) + ".jpeg")
    i = i + 1
