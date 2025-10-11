#!/bin/bash

# Front Matter 추가 스크립트
TIL_ROOT="/Users/jeongcool/me/TIL"
cd "$TIL_ROOT"

# 제외할 파일들
EXCLUDE_FILES=("README.md" "MARKDOWN_METADATA.md")

# 로그 파일
LOGFILE="front_matter_log.txt"
echo "Front Matter 추가 작업 시작: $(date)" > "$LOGFILE"

# 처리된 파일 수
processed_count=0
error_count=0

# 모든 .md 파일 찾기 (제외할 파일 빼고)
find . -name "*.md" -type f | while read -r file; do
    # 상대 경로로 변환
    rel_path="${file#./}"
    
    # 제외할 파일인지 확인
    should_skip=false
    for exclude in "${EXCLUDE_FILES[@]}"; do
        if [[ "$rel_path" == "$exclude" ]]; then
            should_skip=true
            break
        fi
    done
    
    if $should_skip; then
        echo "스킵: $rel_path" >> "$LOGFILE"
        continue
    fi
    
    echo "처리 중: $rel_path" >> "$LOGFILE"
    
    # 이미 Front Matter가 있는지 확인
    if head -1 "$file" | grep -q "^---$"; then
        echo "이미 Front Matter 존재: $rel_path" >> "$LOGFILE"
        continue
    fi
    
    # h1 태그 추출
    title=$(grep -m 1 "^# " "$file" | sed 's/^# //' | sed 's/[[:space:]]*$//')
    if [[ -z "$title" ]]; then
        echo "ERROR: h1 태그를 찾을 수 없음: $rel_path" >> "$LOGFILE"
        ((error_count++))
        continue
    fi
    
    # 경로 분석
    IFS='/' read -ra PATH_PARTS <<< "$rel_path"
    
    # categories (최상위 디렉토리)
    categories="${PATH_PARTS[0]}"
    
    # tags (1depth 제외한 나머지 디렉토리들)
    tags=()
    for ((i=1; i<${#PATH_PARTS[@]}-1; i++)); do
        tags+=("${PATH_PARTS[i]}")
    done
    
    # tags 배열을 문자열로 변환
    if [[ ${#tags[@]} -eq 0 ]]; then
        tags_str="[]"
    else
        tags_str="["
        for ((i=0; i<${#tags[@]}; i++)); do
            if [[ $i -eq 0 ]]; then
                tags_str+="${tags[i]}"
            else
                tags_str+=", ${tags[i]}"
            fi
        done
        tags_str+="]"
    fi
    
    # git 최초 커밋 날짜 조회
    first_commit_date=$(git log --format="%ad" --date=format:"%Y-%m-%d" --reverse -- "$file" | head -1)
    if [[ -z "$first_commit_date" ]]; then
        echo "ERROR: git 히스토리를 찾을 수 없음: $rel_path" >> "$LOGFILE"
        ((error_count++))
        continue
    fi
    
    # 임시 파일 생성
    temp_file=$(mktemp)
    
    # Front Matter 작성
    cat > "$temp_file" << EOF
---
layout: post
author: "정시원"
title: "$title"
categories: $categories
date: $first_commit_date
tags: $tags_str
---

EOF
    
    # 기존 파일 내용 추가
    cat "$file" >> "$temp_file"
    
    # 원본 파일로 복사
    mv "$temp_file" "$file"
    
    ((processed_count++))
    echo "완료: $rel_path (title: $title, categories: $categories, tags: $tags_str, date: $first_commit_date)" >> "$LOGFILE"
    
    # 진행상황 출력 (매 10개마다)
    if (( processed_count % 10 == 0 )); then
        echo "처리된 파일 수: $processed_count"
    fi
done

echo "작업 완료: $(date)" >> "$LOGFILE"
echo "총 처리된 파일: $processed_count" >> "$LOGFILE"
echo "오류 발생 파일: $error_count" >> "$LOGFILE"

echo "Front Matter 추가 작업이 완료되었습니다."
echo "처리된 파일: $processed_count개"
echo "오류 발생: $error_count개"
echo "자세한 로그는 $LOGFILE을 확인하세요."