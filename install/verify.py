class Verify:
  def tensorflow():
    print("\n\nTensorflow Verification Started")
    import tensorflow as tf
    print(f"Verifying CPU Installation \nCPU Results : {tf.reduce_sum(tf.random.normal([1000, 1000]))}")
    print(f"Verifying GPU Installation \nGPU Results : {tf.config.list_physical_devices('GPU')}")
    print("Tensorflow Verification Completed\n\n")
    
  def torch():
    print("\n\nTorch Verification Started")
    import torch
    print(f"Cuda Availability : {torch.cuda.is_available()}")
    print(f"CUDNN Backend : {torch.backends.cudnn.is_available()}")
    print("Torch Verification Completed\n\n")

if __name__ == "__main__":
  print("Welcome to Meliodas's Verify package")