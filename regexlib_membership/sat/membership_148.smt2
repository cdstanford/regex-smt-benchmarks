;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0?[1-9]|1[012])/([012][0-9]|[1-9]|3[01])/([12][0-9]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8/30/2547"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "/" (seq.++ "3" (seq.++ "0" (seq.++ "/" (seq.++ "2" (seq.++ "5" (seq.++ "4" (seq.++ "7" ""))))))))))
;witness2: "5/21/1168"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "/" (seq.++ "2" (seq.++ "1" (seq.++ "/" (seq.++ "1" (seq.++ "1" (seq.++ "6" (seq.++ "8" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9"))(re.union (re.range "1" "9") (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.++ (re.range "1" "2") ((_ re.loop 3 3) (re.range "0" "9"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
