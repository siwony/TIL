#!/bin/bash

# README 파일의 모든 링크를 자동으로 업데이트하는 개선된 스크립트
TIL_ROOT="/Users/jeongcool/me/TIL"
cd "$TIL_ROOT"

README_FILE="README.md"

echo "README 파일의 모든 링크를 자동으로 업데이트합니다..."

# 백업이 이미 있다면 원본을 복원
if [ -f "${README_FILE}.backup" ]; then
    cp "${README_FILE}.backup" "$README_FILE"
fi

# 새 백업 생성
cp "$README_FILE" "${README_FILE}.backup"

# 모든 날짜 접두사가 붙은 파일 찾기
find . -name "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md" -type f | while read -r new_file; do
    # 경로에서 날짜 부분 제거하여 원본 파일명 추출
    original_name=$(basename "$new_file" | sed 's/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-//')
    dir_path=$(dirname "$new_file" | sed 's|^\./||')
    
    old_path=""
    if [ "$dir_path" = "." ]; then
        old_path="$original_name"
    else
        old_path="$dir_path/$original_name"
    fi
    
    new_path=$(echo "$new_file" | sed 's|^\./||')
    
    # README에서 해당 링크 찾아서 변경
    # 상대 경로 링크 업데이트
    if grep -q "($old_path)" "$README_FILE"; then
        sed -i '' "s|($old_path)|($new_path)|g" "$README_FILE"
        echo "✅ 업데이트: $old_path -> $new_path"
    fi
    
    # 절대 경로 링크 업데이트 (/)로 시작
    if grep -q "(/$old_path)" "$README_FILE"; then
        sed -i '' "s|(/$old_path)|(/$new_path)|g" "$README_FILE"
        echo "✅ 업데이트 (절대경로): /$old_path -> /$new_path"
    fi
done

echo ""
echo "README 링크 업데이트가 완료되었습니다!"
echo "백업 파일: ${README_FILE}.backup"

# 변경사항 통계
changes=$(diff "${README_FILE}.backup" "$README_FILE" | grep "^<\|^>" | wc -l)
echo "총 변경된 라인 수: $changes"

echo ""
echo "변경사항을 확인하려면:"
echo "diff ${README_FILE}.backup ${README_FILE}"