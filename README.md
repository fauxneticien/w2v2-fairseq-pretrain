# wav2vec 2.0 XLS-R continued pretraining using fairseq

1. Launch Docker container `docker-compose run gpu`
2. Fetch XLS-R checkpoint:

    ```bash
    wget https://dl.fbaipublicfiles.com/fairseq/wav2vec/xlsr2_300m.pt -P tmp/
    ```

3. Download folder of audio into `data`, e.g. `data/wav`
4. Create manifest of wav folder:

    ```bash
    python wav2vec_manifest.py /workspace/data/wav --ext wav --valid-percent 0.01 --dest data/manifest/
    ```

4. Adjust training parameters in `w2v2-large-cpt.yaml` (e.g. `dataset.max_tokens: 150000` to whatever suits your GPU setup)
5. Run continued pretraining:

    ```bash
    fairseq-hydra-train task.data=/workspace/data/manifest \
        checkpoint.finetune_from_model=/workspace/tmp/xlsr2_300m.pt \
        common.log_format=simple \
        common.fp16=True \
        --config-dir /workspace \
        --config-name w2v2-large-cpt.yaml 
    ```
