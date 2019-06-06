import cv2
import numpy as np
#Se leen las imagenes
#Camp1_IR 
vis = cv2.imread('Road2_Vis.png',0)
ir = cv2.imread('Road2_IR.png',0)
#Se inicializan los elementos Estructurantes
H = np.ones((3,3),np.uint8)
H_prima = np.ones((21,21),np.uint8)
#Se define el paso en el van a ir incrementandose los elementos estructurantes
paso=2
#La cantidad de Iteraciones
iterations=11
#Lista de las imagenes resultantes con el White Top-Hat y Black Top-Hat para la img visible 
vis_wthn_all=[]
vis_bthn_all=[]
#Lista de las diferencias para calcular los WTHN(i)(i+1) y los BTHN(i)(i+1) 
vis_wthn_resta=[]
vis_bthn_resta=[]
#Mismo proceso para la imagen Infrarroja
ir_wthn_all=[]
ir_bthn_all=[]
ir_wthn_resta=[]
ir_bthn_resta=[]
#Se calcula el IB que es el promedio de las imagenes
ib=cv2.add(vis,ir)//2
#Funcion que recibe una lista de imagenes y retorna una imagen con los valores
#de cada pixel mas altos encontrados en las otras imagenes
row=len(vis)
col=len(vis[0])
#Funcion que calcula el White Top-Hat
def wthn(image,h,h_prima):
    return  cv2.subtract(image,cv2.dilate(cv2.erode(image,h,iterations = 1),h_prima,iterations = 1))

#Funcion que calcula el Black Top-Hat
def bthn(image,h,h_prima):
    return  cv2.subtract(cv2.erode(cv2.dilate(image,h,iterations = 1),h_prima,iterations = 1),image)
#Variables que permiten obtener los mayores por pixel para los WTHN y BTHN
max_vis_wthn_all=np.zeros((row,col), np.uint8)
max_ir_wthn_all=np.zeros((row,col), np.uint8)
max_vis_bthn_all=np.zeros((row,col), np.uint8)
max_ir_bthn_all=np.zeros((row,col), np.uint8)
#Inicio del algoritmo
for i in range(iterations):
    #Calculo de los top-hat
    vis_wthn_all.append(wthn(vis,H,H_prima))
    vis_bthn_all.append(bthn(vis,H,H_prima))
    ir_wthn_all.append(wthn(ir,H,H_prima))
    ir_bthn_all.append(bthn(ir,H,H_prima))

    max_vis_wthn_all=cv2.max(max_vis_wthn_all,vis_wthn_all[i])
    max_ir_wthn_all=cv2.max(max_ir_wthn_all,ir_wthn_all[i])
    max_vis_bthn_all=cv2.max(max_vis_bthn_all,vis_bthn_all[i])
    max_ir_bthn_all=cv2.max(max_ir_bthn_all,ir_bthn_all[i])
    #Incremeneto de los elementos estructurantes en 2
    lh=len(H)
    lh_prima=len(H_prima)
    lh+=paso
    lh_prima+=paso
    H = np.ones((lh,lh),np.uint8)
    H_prima = np.ones((lh_prima,lh_prima),np.uint8)

#Se realizan las diferencias para calcular los WTHN(i)(i+1) y los BTHN(i)(i+1)
#Variables para calcular el maximo por pixel para las diferencias de constraste
max_vis_wthn_resta=np.zeros((row,col), np.uint8)
max_ir_wthn_resta=np.zeros((row,col), np.uint8)
max_vis_bthn_resta=np.zeros((row,col), np.uint8)
max_ir_bthn_resta=np.zeros((row,col), np.uint8)
for i in range(iterations-1):
    vis_wthn_resta.append( cv2.subtract(vis_wthn_all[i+1],vis_wthn_all[i]))
    vis_bthn_resta.append( cv2.subtract(vis_bthn_all[i+1],vis_bthn_all[i]))
    ir_wthn_resta.append( cv2.subtract(ir_wthn_all[i+1],ir_wthn_all[i]))
    ir_bthn_resta.append( cv2.subtract(ir_bthn_all[i+1],ir_bthn_all[i]))

    max_vis_wthn_resta=cv2.max(max_vis_wthn_resta,vis_wthn_resta[i])
    max_ir_wthn_resta=cv2.max(max_ir_wthn_resta,ir_wthn_resta[i])
    max_vis_bthn_resta=cv2.max(max_vis_bthn_resta,vis_bthn_resta[i])
    max_ir_bthn_resta=cv2.max(max_ir_bthn_resta,ir_bthn_resta[i])

#Se calulan los operandos finales
fcw=cv2.max(max_vis_wthn_all,max_ir_wthn_all)
fdw=cv2.max(max_vis_wthn_resta,max_ir_wthn_resta)
fcb=cv2.max(max_vis_bthn_all,max_ir_bthn_all)
fdb=cv2.max(max_vis_bthn_resta,max_ir_bthn_resta)
#Imagen Resultante
IF=cv2.add(ib,cv2.subtract(cv2.add(fcw,fdw),cv2.add(fcb,fdb)))
cv2.imshow('image',IF)
cv2.waitKey(0)
cv2.destroyAllWindows()