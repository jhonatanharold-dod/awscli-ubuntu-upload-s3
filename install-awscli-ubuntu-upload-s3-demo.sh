#!/bin/bash
# -*- ENCODING: UTF-8 -*-

S3_BUCKET="develop-or-died"
FOLDER_S3_BUCKET="dev001"
LOCAL_FOLDER_S3_UPLOAD=$HOME"/"$FOLDER_S3_BUCKET
TEST_FILE="testfile.txt"

echo "------------------------------------"
echo "[Instalacion de AWS CLI para UBUNTU]"
echo "------------------------------------"
echo ""

#Se instala el cliente AWS para Ubuntu
echo "[sudo apt install awscli]"
sudo apt install awscli
echo ""

#Verifico la version Instalada del AWS Cli, sera la 1 por defecto
echo "[aws --version]"
aws --version
echo ""

#Se configurara el usuario con el que se conectara el awscli.
#para esto se debe hacer la configuracion de IAM previamente en la consola AWS
#Entrar a la consola AWS, acceder al IAM, boton lateral  usuario, tab credenciales de seguridad, boton crear una clave de acceso
echo "[aws configure]"
aws configure
echo ""

# se creara un folder donde se almacenaran los archivos a subir en el s3
echo "[creando folder: "$LOCAL_FOLDER_S3_UPLOAD"]"
mkdir $LOCAL_FOLDER_S3_UPLOAD
echo ""

#doy permisos al folder
echo "[dando permisos :: chmod x+ "$LOCAL_FOLDER_S3_UPLOAD"]"
chmod +x $LOCAL_FOLDER_S3_UPLOAD 
echo ""

#creare un archivo de pruebas
echo "[creando archivo de prueba:: "$TEST_FILE"]"
echo "Este es un archivo de prueba que se subira al S3" > $LOCAL_FOLDER_S3_UPLOAD/$TEST_FILE
echo ""

#muestro como subire el archivo de pruebas
echo "[subiendo archivo de prueba]"
echo "aws s3 sync" $LOCAL_FOLDER_S3_UPLOAD "s3://"$S3_BUCKET"/"$FOLDER_S3_BUCKET
echo ""

#ejecutando
aws s3 sync $LOCAL_FOLDER_S3_UPLOAD s3://$S3_BUCKET/$FOLDER_S3_BUCKET
echo ""

#creando un archivo de ejecucion para el upload
cd $HOME && 
echo '#!/bin/bash' >> upload-files-s3.sh && 
echo '# -*- ENCODING: UTF-8 -*-' >> upload-files-s3.sh && 
echo "aws s3 sync" $LOCAL_FOLDER_S3_UPLOAD "s3://"$S3_BUCKET"/"$FOLDER_S3_BUCKET >> upload-files-s3.sh
echo ""
echo "[Cada vez que quiera ejecutar un upload solo acceda a la carpeta "$HOME" y ejecute sh upload-files-s3.sh ]"



