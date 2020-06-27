docker exec -it tensorflow bash

nvidia-smi

python
from tensorflow.python.client import device_lib
device_lib.list_local_devices()

python
import tensorflow as tf
device = tf.test.gpu_device_name()
device

