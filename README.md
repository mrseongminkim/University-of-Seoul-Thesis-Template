# University of Seoul — Thesis LaTeX Template

서울시립대학교 일반대학원 학위논문 LaTeX 템플릿입니다. 대학원 「학위논문 체제 및 양식」을 `pdflatex` + `kotex` 기반으로 구현했습니다.

이 템플릿은 개인이 제작한 **비공식** 프로젝트이며 서울시립대학교와 공식적인 관련이 없습니다. 다만 이 템플릿으로 작성한 논문이 **2026년 8월 학위논문 심사를 통과**했습니다. 양식 규정은 개정될 수 있으니 제출 전 최신 규정과 대조하시기 바랍니다.

## 요구사항

- TeX Live 2022 이상 (또는 MiKTeX)
- 컴파일러: `pdflatex`
- 주요 패키지: `kotex`, `biblatex` + `biber`

## 컴파일

```bash
# latexmk (권장)
latexmk -pdf main.tex

# 또는 수동
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

## 사용법

1. `main.tex` 상단의 메타데이터를 본인 정보로 채웁니다.
2. `chapters/`에 본문 장을 작성하고 `main.tex`에서 `\include` 합니다.
3. `references.bib`에 참고문헌을 추가합니다.
4. 영문초록(`abstract`), 국문초록(`abstractko`), 감사문(`acknowledgments`)을 작성합니다.

석사/박사는 클래스 옵션으로 전환합니다.

```latex
\documentclass[master]{uos-thesis}   % 석사 (기본)
\documentclass[doctor]{uos-thesis}   % 박사
```

## 구조

```
main.tex         # 메인 문서 (메타데이터 + 구성)
uos-thesis.cls   # 논문 클래스 파일
references.bib   # 참고문헌
chapters/        # 본문 장
```

## 라이선스

[MIT License](LICENSE)
