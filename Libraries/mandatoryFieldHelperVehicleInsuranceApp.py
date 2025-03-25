def simple_image_compare_Icons(filename):
    import cv2
    #import numpy as np

    from PIL import Image
    img = Image.open(filename)
    #print(img.size)
    #print(img.size[0])
    #print(img.size[1])

    # Lade die Bilder
    imgIconMissingMandatory = cv2.imread('Resources/Images/MissingMandatoryField.png')
    #imgIconFilledMandatory = cv2.imread('Resources/Images/FilledMandatoryField.png')
    imgIconActual = cv2.imread(filename)

    # Konvertiere die Bilder in Graustufen
    imgIconMissingMandatory_gray = cv2.cvtColor(imgIconMissingMandatory, cv2.COLOR_BGR2GRAY)
    #imgIconFilledMandatory_gray = cv2.cvtColor(imgIconFilledMandatory, cv2.COLOR_BGR2GRAY)
    imgIconActual_gray = cv2.cvtColor(imgIconActual, cv2.COLOR_BGR2GRAY)

    # Berechne den strukturellen Ähnlichkeitsindex (SSIM)
    from skimage.metrics import structural_similarity
    score, diff = structural_similarity(imgIconMissingMandatory_gray, imgIconActual_gray, full=True)
    diff = (diff * 255).astype("uint8")
    print(f"Ähnlichkeitswert imgIconMissingMandatory: {score}")

    if score > 0.5:
        return "<MissingMandatoryField>"

    imgIconFilledMandatory = cv2.imread('Resources/Images/FilledMandatoryField.png')
    imgIconFilledMandatory_gray = cv2.cvtColor(imgIconFilledMandatory, cv2.COLOR_BGR2GRAY)

    score, diff = structural_similarity(imgIconFilledMandatory_gray, imgIconActual_gray, full=True)
    diff = (diff * 255).astype("uint8")
    print(f"Ähnlichkeitswert imgIconFilledMandatory: {score}")

    if score > 0.5:
        return "<FilledMandatoryField>"

    return "ERROR: unknown icon!"