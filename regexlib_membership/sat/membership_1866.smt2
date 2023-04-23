;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9])|(0[1-9])|(1[0-2]))\/((0[1-9])|([1-31]))\/((\d{2})|(\d{4}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "08/3/58"
(define-fun Witness1 () String (str.++ "0" (str.++ "8" (str.++ "/" (str.++ "3" (str.++ "/" (str.++ "5" (str.++ "8" ""))))))))
;witness2: "12/3/9986"
(define-fun Witness2 () String (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "3" (str.++ "/" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.range "1" "3"))(re.++ (re.range "/" "/")(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
