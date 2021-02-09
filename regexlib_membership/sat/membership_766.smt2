;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((http|https|ftp)\://|www\.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,4}(/[a-zA-Z0-9\-\._\?=\,\'\+%\$#~]*[^\.\,\)\(\s])*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "https://..tP/F/qX/b/928\u0097/\u00DB/-{/,\u008A"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "." (seq.++ "." (seq.++ "t" (seq.++ "P" (seq.++ "/" (seq.++ "F" (seq.++ "/" (seq.++ "q" (seq.++ "X" (seq.++ "/" (seq.++ "b" (seq.++ "/" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "\x97" (seq.++ "/" (seq.++ "\xdb" (seq.++ "/" (seq.++ "-" (seq.++ "{" (seq.++ "/" (seq.++ "," (seq.++ "\x8a" "")))))))))))))))))))))))))))))))))
;witness2: "ftp://9.Act"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "9" (seq.++ "." (seq.++ "A" (seq.++ "c" (seq.++ "t" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" "")))))) (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))) (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.range "/" "/")(re.++ (re.* (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))) (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
