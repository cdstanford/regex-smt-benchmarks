;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0]?[1-9])|(1[0-2]))\/(([0]?[1-9])|([1,2]\d{1})|([3][0,1]))\/[12]\d{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4/3,/2319"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "/" (seq.++ "3" (seq.++ "," (seq.++ "/" (seq.++ "2" (seq.++ "3" (seq.++ "1" (seq.++ "9" ""))))))))))
;witness2: "11/6/1994"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "1" (seq.++ "/" (seq.++ "6" (seq.++ "/" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "4" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.union (re.range "," ",") (re.range "1" "2")) (re.range "0" "9")) (re.++ (re.range "3" "3") (re.union (re.range "," ",") (re.range "0" "1")))))(re.++ (re.range "/" "/")(re.++ (re.range "1" "2")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
