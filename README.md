# nof
Personal script to create backup

___

[🇺🇸 Switch to English](README_en.md)

**¿Alguna vez cometiste un error con los datos dentro de un disco y te valió que tus amigos te digan "F"?** Bueno, a mi sí, y por eso decidí crear éste script. Ahora puedo gritarles en la cara "NO MÁS F". O eso espero.

Por el momento éste script satisface sólo mis demandas personales. Con el tiempo puede que lo mejore, pero no prometo nada.

El script `setup.sh` permite instalar o desinstalar `nof`, con sus respectivas opciones (vea la ayuda con `setup.sh --help`). Además, configura un servicio y un timer con systemd para que se ejecute automágicamente una vez a la semana.

**¿Qué es lo que hace (al menos por el momento)?** Bien, simplemente consta de un timer que se va a disparar una vez a la semana. Cuando ésto sucede, activa un servicio que se encarga de ejecutar el script `nof`. Dicho script crea un backup (tipo 0) con la herramienta `tar` y lo almacena en un directorio oculto, dentro del home del usuario. Si está activa la opción, también puede enviarlo vía SSH (usando `scp`) a un directorio remoto. En mi caso, lo utilizo para tener una copia de los backups en un disco conectado a mi Raspberry Pi. Lógicamente, se debe configurar SSH apropiadamente para que el script no deba rellenar los campos de logueo. Por último, también se encarga de hacer rotación de los backups para que nuestra máquina no se llene de backups antiguos. Puede configurarse dentro del script, pero por defecto mantiene siempre los 5 respaldos más nuevos.

**¿Planes a futuro?** Tengo ganas de hacerlo aún más generico y añadirle unas cuantas opciones, como almacenamiento en la nube y la opción de generar backups incrementales, pero eso me demanda bastante tiempo que, por el momento no tengo. Sin embargo, cualquier idea, sugerencia o revisión es más que bienvenida.
