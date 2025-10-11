#!/bin/bash

# Front Matter의 date를 기반으로 파일명을 변경하는 스크립트
# git mv를 사용하여 git history를 보존합니다.
# README 파일의 링크도 함께 업데이트합니다.

TIL_ROOT="/Users/jeongcool/me/TIL"
cd "$TIL_ROOT"

# 로그 파일
LOGFILE="rename_files_log.txt"
echo "파일명 변경 작업 시작: $(date)" > "$LOGFILE"

# 카운터
processed_count=0
error_count=0
skipped_count=0
link_update_count=0

# README 파일들 찾기
README_FILES=($(find . -name "README.md" -type f))

echo "Front Matter가 있는 모든 .md 파일의 파일명을 date 기반으로 변경합니다..."
echo "README.md와 MARKDOWN_METADATA.md는 제외됩니다."
echo "README 파일의 링크도 함께 업데이트됩니다."
echo ""

# Front Matter가 있는 모든 .md 파일 찾기 (README.md, MARKDOWN_METADATA.md 제외)
find . -name "*.md" -type f -exec grep -l "^---$" {} \; | grep -v README.md | grep -v MARKDOWN_METADATA.md | while read -r file; do
    # 상대 경로로 변환
    rel_path="${file#./}"
    
    echo "처리 중: $rel_path" | tee -a "$LOGFILE"
    
    # 파일명에서 디렉토리와 파일명 분리
    dir_path=$(dirname "$rel_path")
    filename=$(basename "$rel_path")
    filename_without_ext="${filename%.*}"
    
    # 이미 날짜 형식(YYYY-MM-DD)으로 시작하는 파일인지 확인
    if [[ "$filename" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-.* ]]; then
        echo "이미 날짜 형식으로 시작하는 파일: $rel_path" | tee -a "$LOGFILE"
        ((skipped_count++))
        continue
    fi
    
    # Front Matter에서 date 추출
    date_line=$(head -10 "$file" | grep "^date:" | head -1)
    if [[ -z "$date_line" ]]; then
        echo "ERROR: date 필드를 찾을 수 없음: $rel_path" | tee -a "$LOGFILE"
        ((error_count++))
        continue
    fi
    
    # date 값 추출 (date: 2022-03-19 형식)
    date_value=$(echo "$date_line" | sed 's/^date: *//' | sed 's/[[:space:]]*$//')
    
    # 날짜 형식 검증 (YYYY-MM-DD)
    if ! [[ "$date_value" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "ERROR: 잘못된 날짜 형식: $date_value in $rel_path" | tee -a "$LOGFILE"
        ((error_count++))
        continue
    fi
    
    # 새 파일명 생성
    new_filename="${date_value}-${filename}"
    new_path="${dir_path}/${new_filename}"
    
    # 새 파일명이 이미 존재하는지 확인
    if [[ -f "$new_path" ]]; then
        echo "ERROR: 새 파일명이 이미 존재함: $new_path" | tee -a "$LOGFILE"
        ((error_count++))
        continue
    fi
    
    # git mv 실행
    if git mv "$rel_path" "$new_path"; then
        echo "성공: $rel_path -> $new_path" | tee -a "$LOGFILE"
        ((processed_count++))
        
        # README 파일들의 링크 업데이트
        for readme in "${README_FILES[@]}"; do
            # 현재 파일에서 rel_path에 대한 링크가 있는지 확인
            if grep -q "(\|](.*/)\\?$filename)" "$readme" 2>/dev/null; then
                # 상대 경로로 링크 업데이트
                # 절대 경로와 상대 경로 모두 처리
                sed -i.bak \
                    -e "s|(\([^)]*\/\)\?$filename)|(\1$new_filename)|g" \
                    -e "s|](\([^)]*\/\)\?$filename)|](\1$new_filename)|g" \
                    "$readme"
                
                # 백업 파일 삭제
                rm -f "$readme.bak"
                
                echo "README 링크 업데이트: $readme에서 $filename -> $new_filename" | tee -a "$LOGFILE"
                ((link_update_count++))
            fi
        done
        
    else
        echo "ERROR: git mv 실패: $rel_path" | tee -a "$LOGFILE"
        ((error_count++))
    fi
    
    # 진행상황 출력 (매 10개마다)
    if (( (processed_count + error_count) % 10 == 0 )); then
        echo "진행상황: 처리 완료 $processed_count개, 오류 $error_count개, 건너뜀 $skipped_count개"
    fi
done

echo ""
echo "파일명 변경 작업이 완료되었습니다!"
echo "처리 완료: $processed_count개"
echo "오류 발생: $error_count개" 
echo "건너뜀: $skipped_count개"
echo "README 링크 업데이트: $link_update_count개"
echo "자세한 로그는 $LOGFILE을 확인하세요."
echo ""
echo "git 상태 확인:"
git status --porcelain | grep "^R " | wc -l | xargs echo "renamed 파일 수:"

echo ""
echo "변경사항을 커밋하려면 다음 명령을 실행하세요:"
echo "git add ."
echo "git commit -m 'Rename markdown files with date prefix and update README links'"