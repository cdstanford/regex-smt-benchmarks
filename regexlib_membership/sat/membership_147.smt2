;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((2[0-5][0-5]|1[\d][\d]|[\d][\d]|[\d])\.){3}(2[0-5][0-5]|1[\d][\d]|[\d][\d]|[\d])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "169.180.111.0"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "6" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "." (seq.++ "1" (seq.++ "1" (seq.++ "1" (seq.++ "." (seq.++ "0" ""))))))))))))))
;witness2: "214.23.214.9"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "1" (seq.++ "4" (seq.++ "." (seq.++ "2" (seq.++ "3" (seq.++ "." (seq.++ "2" (seq.++ "1" (seq.++ "4" (seq.++ "." (seq.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "5") (re.range "0" "5")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.range "0" "9")))) (re.range "." ".")))(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "5") (re.range "0" "5")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
