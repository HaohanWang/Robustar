# setup
# ./robustar.sh -m setup -a cuda11.1-0.0.1-beta \

## Running on cuda11.1 (For linux users)
./robustar.sh -m run -p 8081 \
-a "cuda11.1-0.0.1-beta" \
-t "/Robustar2/dataset/train" \
-e "/Robustar2/dataset/test" \
-i "/Robustar2/influence_images" \
-o "/Robustar2/configs.json" \
-c "/Robustar2/checkpoints" 

## Running on cpu (For windows users)
# ./robustar.sh \
# -m run \
# -a cpu-0.0.1-beta \
# -p 8080 \
# -t C:\\Robustar2\\dataset\\train \
# -e C:\\Robustar2\\dataset\\test \
# -i C:\\Robustar2\\influence_images \
# -c C:\\Robustar2\\checkpoints \
# -o C:\\Robustar2\\configs.json

