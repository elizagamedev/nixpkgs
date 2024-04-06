{ lib
, fetchFromGitHub
, buildPythonPackage

  # build-system
, setuptools

  # runtime
, ffmpeg-headless

  # propagates
, faster-whisper
, ffmpeg-python
, nltk
, pandas
, pyannote-audio
, torch
, torchaudio
, transformers
}:

buildPythonPackage rec {
  pname = "whisperx";
  version = "3.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "m-bain";
    repo = "whisperX";
    rev = "refs/tags/v${version}";
    hash = "sha256-fwK3hYtFgvPoWAjSxm/nn1FsxOZ32FCanyfWinwoh8Q=";
  };

  postPatch = ''
    # Remove strict version requirements.
    sed -i 's/==.*//' requirements.txt
  '';

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    faster-whisper
    ffmpeg-python
    nltk
    pandas
    pyannote-audio
    torch
    torchaudio
    transformers
  ];

  meta = with lib; {
    description = "Automatic Speech Recognition with Word-level Timestamps (& Diarization)";
    homepage = "https://github.com/m-bain/whisperX";
    license = licenses.bsdOriginal;
    maintainers = with maintainers; [ elizagamedev ];
  };
}
