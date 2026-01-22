import torch
from torchvision.models import resnet50, ResNet50_Weights
from PIL import Image

torch.backends.nnpack.enabled = False

# 1. Load default pretrained weights
weights = ResNet50_Weights.DEFAULT
model = resnet50(weights=weights)
model.eval()

# 2. Get the preprocessing transform *bundled with the weights*
preprocess = weights.transforms()

# 3. Load and preprocess an image
img = Image.open("images/cat.png").convert("RGB")
x = preprocess(img).unsqueeze(0)  # add batch dimension

# 4. Run inference
with torch.no_grad():
    logits = model(x)

# 5. Convert to probabilities and labels
probs = torch.softmax(logits, dim=1)
top5 = probs.topk(20)

categories = weights.meta["categories"]
for score, idx in zip(top5.values[0], top5.indices[0]):
    print(categories[idx], float(score))
