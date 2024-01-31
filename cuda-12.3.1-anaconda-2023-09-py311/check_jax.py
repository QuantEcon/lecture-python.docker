import jax
print(f"JAX backend: {jax.devices()[0].platform}")