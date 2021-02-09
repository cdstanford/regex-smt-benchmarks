;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9!$'*+\-_]+(\.[a-z0-9!$'*+\-_]+)*@([a-z0-9]+(-+[a-z0-9]+)*\.)+([a-z]{2}|aero|arpa|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|travel)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "hg.2@zag.aero"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "g" (seq.++ "." (seq.++ "2" (seq.++ "@" (seq.++ "z" (seq.++ "a" (seq.++ "g" (seq.++ "." (seq.++ "a" (seq.++ "e" (seq.++ "r" (seq.++ "o" ""))))))))))))))
;witness2: "$.4@a9--s--9.biz"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "." (seq.++ "4" (seq.++ "@" (seq.++ "a" (seq.++ "9" (seq.++ "-" (seq.++ "-" (seq.++ "s" (seq.++ "-" (seq.++ "-" (seq.++ "9" (seq.++ "." (seq.++ "b" (seq.++ "i" (seq.++ "z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "'" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "'" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.* (re.++ (re.+ (re.range "-" "-")) (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))))) (re.range "." "."))))(re.++ (re.union ((_ re.loop 2 2) (re.range "a" "z"))(re.union (str.to_re (seq.++ "a" (seq.++ "e" (seq.++ "r" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "a" (seq.++ "r" (seq.++ "p" (seq.++ "a" "")))))(re.union (str.to_re (seq.++ "b" (seq.++ "i" (seq.++ "z" ""))))(re.union (str.to_re (seq.++ "c" (seq.++ "a" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))(re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "o" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "e" (seq.++ "d" (seq.++ "u" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "v" ""))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "f" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "o" (seq.++ "b" (seq.++ "s" "")))))(re.union (str.to_re (seq.++ "m" (seq.++ "i" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "b" (seq.++ "i" "")))))(re.union (str.to_re (seq.++ "m" (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "u" (seq.++ "m" "")))))))(re.union (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "p" (seq.++ "r" (seq.++ "o" "")))) (str.to_re (seq.++ "t" (seq.++ "r" (seq.++ "a" (seq.++ "v" (seq.++ "e" (seq.++ "l" "")))))))))))))))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
