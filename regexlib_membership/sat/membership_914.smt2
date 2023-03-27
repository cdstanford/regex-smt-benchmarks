;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9!$'*+\-_]+(\.[a-z0-9!$'*+\-_]+)*@([a-z0-9]+(-+[a-z0-9]+)*\.)+([a-z]{2}|aero|arpa|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|travel)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "hg.2@zag.aero"
(define-fun Witness1 () String (str.++ "h" (str.++ "g" (str.++ "." (str.++ "2" (str.++ "@" (str.++ "z" (str.++ "a" (str.++ "g" (str.++ "." (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" ""))))))))))))))
;witness2: "$.4@a9--s--9.biz"
(define-fun Witness2 () String (str.++ "$" (str.++ "." (str.++ "4" (str.++ "@" (str.++ "a" (str.++ "9" (str.++ "-" (str.++ "-" (str.++ "s" (str.++ "-" (str.++ "-" (str.++ "9" (str.++ "." (str.++ "b" (str.++ "i" (str.++ "z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "'" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "'" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.* (re.++ (re.+ (re.range "-" "-")) (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))))) (re.range "." "."))))(re.++ (re.union ((_ re.loop 2 2) (re.range "a" "z"))(re.union (str.to_re (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" "")))))(re.union (str.to_re (str.++ "a" (str.++ "r" (str.++ "p" (str.++ "a" "")))))(re.union (str.to_re (str.++ "b" (str.++ "i" (str.++ "z" ""))))(re.union (str.to_re (str.++ "c" (str.++ "a" (str.++ "t" ""))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" ""))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))(re.union (str.to_re (str.++ "e" (str.++ "d" (str.++ "u" ""))))(re.union (str.to_re (str.++ "g" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "t" ""))))(re.union (str.to_re (str.++ "j" (str.++ "o" (str.++ "b" (str.++ "s" "")))))(re.union (str.to_re (str.++ "m" (str.++ "i" (str.++ "l" ""))))(re.union (str.to_re (str.++ "m" (str.++ "o" (str.++ "b" (str.++ "i" "")))))(re.union (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" "")))))))(re.union (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" "")))))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "t" ""))))(re.union (str.to_re (str.++ "o" (str.++ "r" (str.++ "g" ""))))(re.union (str.to_re (str.++ "p" (str.++ "r" (str.++ "o" "")))) (str.to_re (str.++ "t" (str.++ "r" (str.++ "a" (str.++ "v" (str.++ "e" (str.++ "l" "")))))))))))))))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
