import streamlit as st
import subprocess
import tempfile
import pathlib
import resource
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import random

# Benchmarking configurations
TAMANHOS_N = [1000, 5000, 10000, 25000, 50000, 100000]
REPETICOES = 3


def compile_cpp(source_path, bin_path):
    """Compiles the C++ source code"""
    result = subprocess.run(
        ["g++", "-O3", str(source_path), "-o", str(bin_path)],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise Exception(f"Erro de Compilação: {result.stderr}")


def run_benchmark(bin_path, n, algorithm_type):
    """Generates input, executes binary and measures CPU Time"""
    # Input generation based on algorithm type
    if "Busca" in algorithm_type or "Search" in algorithm_type:
        data = sorted([random.randint(0, n * 10) for _ in range(n)])
        target = random.choice(data)
        input_str = f"{n}\n" + " ".join(map(str, data)) + f"\n{target}"
    else:  # Sorting
        data = [random.randint(0, n * 10) for _ in range(n)]
        input_str = f"{n}\n" + " ".join(map(str, data))

    usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)

    # Execution sending data via stdin
    process = subprocess.Popen(
        [str(bin_path)], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True
    )
    process.communicate(input=input_str)

    usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)

    # CPU Time calculation (User + System)
    cpu_time = (usage_end.ru_utime - usage_start.ru_utime) + (
        usage_end.ru_stime - usage_start.ru_stime
    )

    return cpu_time


st.title("Análise Empírica de Complexidade")

# Algorithm type selection (UI in Portuguese)
option = st.selectbox("Tipo de algoritmo", ("Busca", "Ordenação"))
uploaded_files = st.file_uploader(
    "Upload dos fontes (.cpp)", accept_multiple_files=True, type=["cpp"]
)

if st.button("Iniciar Análise") and uploaded_files:
    results = []

    with tempfile.TemporaryDirectory() as temp_dir:
        temp_path = pathlib.Path(temp_dir)

        for uploaded_file in uploaded_files:
            with st.status(
                f"Processando {uploaded_file.name}...", expanded=True
            ) as status:
                # 1. Save and Compile
                source_path = temp_path / uploaded_file.name
                bin_path = temp_path / f"{uploaded_file.name}.out"
                source_path.write_bytes(uploaded_file.getvalue())

                try:
                    compile_cpp(source_path, bin_path)
                    st.write("✅ Compilado com sucesso")
                except Exception as e:
                    st.error(e)
                    continue

                # 2. Run Benchmarks
                for n in TAMANHOS_N:
                    iteration_times = []
                    for r in range(REPETICOES):
                        t = run_benchmark(bin_path, n, option)
                        iteration_times.append(t)

                    avg_time = sum(iteration_times) / REPETICOES
                    results.append(
                        {
                            "Algoritmo": uploaded_file.name,
                            "n": n,
                            "Tempo CPU (s)": avg_time,
                        }
                    )
                    st.write(f"Finalizado n={n} (média de {REPETICOES} repetições)")

                status.update(
                    label=f"Concluído: {uploaded_file.name}", state="complete"
                )

    # 3. Visualization
    if results:
        df = pd.DataFrame(results)
        st.subheader("Resultados da Análise")

        fig, ax = plt.subplots(figsize=(10, 6))
        sns.lineplot(
            data=df, x="n", y="Tempo CPU (s)", hue="Algoritmo", marker="o", ax=ax
        )
        ax.set_title(f"Crescimento do Tempo - {option}")
        ax.grid(True, linestyle="--", alpha=0.6)

        st.pyplot(fig)
