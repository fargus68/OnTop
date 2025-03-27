def simple_image_compare_Icons(filename):
    import cv2
    #import numpy as np

    from PIL import Image
    img = Image.open(filename)
    print(img.size)
    print(img.size[0])
    print(img.size[1])
    imgIconActual = cv2.imread(filename)
    imgIconActual_gray = cv2.cvtColor(imgIconActual, cv2.COLOR_BGR2GRAY)

    if img.size[1] == 16:
        imgIconMissingMandatory = cv2.imread('Resources/Images/MissingMandatoryField_17_16.png')
    else:
        imgIconMissingMandatory = cv2.imread('Resources/Images/MissingMandatoryField.png')
    imgIconMissingMandatory_gray = cv2.cvtColor(imgIconMissingMandatory, cv2.COLOR_BGR2GRAY)

    # Berechne den strukturellen Ähnlichkeitsindex (SSIM)
    from skimage.metrics import structural_similarity
    score, diff = structural_similarity(imgIconMissingMandatory_gray, imgIconActual_gray, full=True)
    diff = (diff * 255).astype("uint8")
    print(f"Ähnlichkeitswert imgIconMissingMandatory: {score}")

    if score > 0.5:
        return "<MissingMandatoryField>"

    if img.size[1] == 16:
        imgIconFilledMandatory = cv2.imread('Resources/Images/FilledMandatoryField_17_16.png')
    else:
        imgIconFilledMandatory = cv2.imread('Resources/Images/FilledMandatoryField.png')
    imgIconFilledMandatory_gray = cv2.cvtColor(imgIconFilledMandatory, cv2.COLOR_BGR2GRAY)

    score, diff = structural_similarity(imgIconFilledMandatory_gray, imgIconActual_gray, full=True)
    diff = (diff * 255).astype("uint8")
    print(f"Ähnlichkeitswert imgIconFilledMandatory: {score}")

    if score > 0.5:
        return "<FilledMandatoryField>"

    return "ERROR: unknown icon!"