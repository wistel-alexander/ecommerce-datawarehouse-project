from docx import Document

doc = Document('docs/Proyecto Productivo SENA.docx')

for para in doc.paragraphs:
    print(para.text)