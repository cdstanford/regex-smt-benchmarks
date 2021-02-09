;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-2][0-4](?:(?:(?::)?[0-5][0-9])?|(?:(?::)?[0-5][0-9](?::)?[0-5][0-9](?:\.[0-9]+)?)?)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "24:09:38"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "4" (seq.++ ":" (seq.++ "0" (seq.++ "9" (seq.++ ":" (seq.++ "3" (seq.++ "8" "")))))))))
;witness2: "02:48:41"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "2" (seq.++ ":" (seq.++ "4" (seq.++ "8" (seq.++ ":" (seq.++ "4" (seq.++ "1" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "0" "2")(re.++ (re.range "0" "4") (re.opt (re.union (re.opt (re.++ (re.opt (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9")))) (re.opt (re.++ (re.opt (re.range ":" ":"))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range ":" ":"))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
