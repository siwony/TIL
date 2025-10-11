#!/bin/bash

# README 파일의 링크를 자동으로 업데이트하는 스크립트
TIL_ROOT="/Users/jeongcool/me/TIL"
cd "$TIL_ROOT"

README_FILE="README.md"

echo "README 파일의 링크를 자동으로 업데이트합니다..."

# 백업 생성
cp "$README_FILE" "${README_FILE}.backup"

# 현재 존재하는 모든 날짜 접두사가 붙은 마크다운 파일을 찾아서 매핑 생성
declare -A file_mapping

# 모든 날짜 접두사가 붙은 파일을 찾아서 원본 파일명과 매핑
find . -name "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md" -type f | while read -r new_file; do
    # ./path/2022-03-19-filename.md에서 ./path/filename.md 추출
    old_file=$(echo "$new_file" | sed 's|/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-||')
    old_file_relative=$(echo "$old_file" | sed 's|^\./||')
    new_file_relative=$(echo "$new_file" | sed 's|^\./||')
    
    echo "매핑: $old_file_relative -> $new_file_relative"
    
    # README에서 해당 링크를 찾아서 변경
    if grep -q "($old_file_relative)" "$README_FILE"; then
        sed -i '' "s|($old_file_relative)|($new_file_relative)|g" "$README_FILE"
        echo "업데이트: $old_file_relative -> $new_file_relative"
    fi
    
    # 절대 경로 형태의 링크도 확인 (/)로 시작하는 경우
    if grep -q "(/$old_file_relative)" "$README_FILE"; then
        sed -i '' "s|(/$old_file_relative)|(/$new_file_relative)|g" "$README_FILE"
        echo "업데이트 (절대경로): /$old_file_relative -> /$new_file_relative"
    fi
done

echo "README 링크 업데이트가 완료되었습니다!"
echo "백업 파일: ${README_FILE}.backup"

# 변경사항 확인
echo "변경된 내용을 확인하려면 다음 명령을 실행하세요:"
echo "diff ${README_FILE}.backup ${README_FILE}"