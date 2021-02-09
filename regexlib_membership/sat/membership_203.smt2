;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-2]\d|3[0-1]|[1-9])\/(0\d|1[0-2]|[1-9])\/(\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9/00/8031"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "/" (seq.++ "0" (seq.++ "0" (seq.++ "/" (seq.++ "8" (seq.++ "0" (seq.++ "3" (seq.++ "1" ""))))))))))
;witness2: "17/10/8589"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "7" (seq.++ "/" (seq.++ "1" (seq.++ "0" (seq.++ "/" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9"))(re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (re.range "1" "9")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.range "1" "9")))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
