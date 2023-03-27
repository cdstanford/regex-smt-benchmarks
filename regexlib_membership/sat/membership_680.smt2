;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1..9])|(0[1..9])|(1\d)|(2\d)|(3[0..1])).((\d)|(0\d)|(1[0..2])).(\d{4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "29t1.C8129"
(define-fun Witness1 () String (str.++ "2" (str.++ "9" (str.++ "t" (str.++ "1" (str.++ "." (str.++ "C" (str.++ "8" (str.++ "1" (str.++ "2" (str.++ "9" "")))))))))))
;witness2: "09H08\u00DB4888"
(define-fun Witness2 () String (str.++ "0" (str.++ "9" (str.++ "H" (str.++ "0" (str.++ "8" (str.++ "\u{db}" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "." ".")(re.union (re.range "1" "1") (re.range "9" "9")))(re.union (re.++ (re.range "0" "0") (re.union (re.range "." ".")(re.union (re.range "1" "1") (re.range "9" "9"))))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.union (re.range "." ".") (re.range "0" "1")))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.union (re.range "." ".")(re.union (re.range "0" "0") (re.range "2" "2"))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
