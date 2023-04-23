;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0][0-9]|[1][0-2])|[0-9]):([0-5][0-9])( *)((AM|PM)|(A|P))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "10:58P"
(define-fun Witness1 () String (str.++ "1" (str.++ "0" (str.++ ":" (str.++ "5" (str.++ "8" (str.++ "P" "")))))))
;witness2: "06:22A"
(define-fun Witness2 () String (str.++ "0" (str.++ "6" (str.++ ":" (str.++ "2" (str.++ "2" (str.++ "A" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.union (str.to_re (str.++ "A" (str.++ "M" ""))) (str.to_re (str.++ "P" (str.++ "M" "")))) (re.union (re.range "A" "A") (re.range "P" "P"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
