# Heart rate from ECG

Detects ECG peaks, plots seven diagnostic views, and computes instantaneous beats per minute.

## Setup and execution

Open this folder in MATLAB and run:

```matlab
[peakBPM, bpm, peakTimes] = heart_rate('ECG6.dat', 200, 2400);
```

## Inputs

No fixed external dataset is required for the default entry point. See the notes below for bundled files or command-line input requirements.

## Outputs

Peak BPM, instantaneous BPM values, peak times, and diagnostic figures.

## Implementation and limitations

Requires MATLAB and Signal Processing Toolbox (findpeaks). ECG3.dat through ECG6.dat are bundled. Defaults preserve ECG6, 200 Hz, and a peak-height threshold of 2400; minimum peak distance remains half a second. Elementwise division corrects the original matrix-division error. MATLAB was unavailable for execution.

## Verification

The workspace regression suite checks source/notebook validity and selected behavior with bundled or synthetic inputs. Full experiment training and historical metric reproduction are not implied. See the workspace `REFACTOR_REPORT.md` for exact test coverage and unresolved runtime requirements.

Toolbox requirements are also listed in `requirements-matlab.txt`; this is not a pip requirements file.
