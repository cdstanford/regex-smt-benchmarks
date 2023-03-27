;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(3276[0-7]|327[0-5]\d|32[0-6]\d{2}|3[01]\d{3}|[12]\d{4}|[1-9]\d{3}|[1-9]\d{2}|[1-9]\d|\d)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "32766"
(define-fun Witness1 () String (str.++ "3" (str.++ "2" (str.++ "7" (str.++ "6" (str.++ "6" ""))))))
;witness2: "30870"
(define-fun Witness2 () String (str.++ "3" (str.++ "0" (str.++ "8" (str.++ "7" (str.++ "0" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "3" (str.++ "2" (str.++ "7" (str.++ "6" ""))))) (re.range "0" "7"))(re.union (re.++ (str.to_re (str.++ "3" (str.++ "2" (str.++ "7" ""))))(re.++ (re.range "0" "5") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "3" (str.++ "2" "")))(re.++ (re.range "0" "6") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (re.range "3" "3")(re.++ (re.range "0" "1") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "2") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
