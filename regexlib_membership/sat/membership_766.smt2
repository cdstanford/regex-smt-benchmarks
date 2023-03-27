;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((http|https|ftp)\://|www\.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,4}(/[a-zA-Z0-9\-\._\?=\,\'\+%\$#~]*[^\.\,\)\(\s])*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "https://..tP/F/qX/b/928\u0097/\u00DB/-{/,\u008A"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "." (str.++ "." (str.++ "t" (str.++ "P" (str.++ "/" (str.++ "F" (str.++ "/" (str.++ "q" (str.++ "X" (str.++ "/" (str.++ "b" (str.++ "/" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "\u{97}" (str.++ "/" (str.++ "\u{db}" (str.++ "/" (str.++ "-" (str.++ "{" (str.++ "/" (str.++ "," (str.++ "\u{8a}" "")))))))))))))))))))))))))))))))))
;witness2: "ftp://9.Act"
(define-fun Witness2 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "9" (str.++ "." (str.++ "A" (str.++ "c" (str.++ "t" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" "")))))) (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" "")))))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))) (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.range "/" "/")(re.++ (re.* (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))) (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
