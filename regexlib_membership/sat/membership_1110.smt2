;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A][Z](.?)[0-9]{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "AZ\u00908669"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "Z" (seq.++ "\x90" (seq.++ "8" (seq.++ "6" (seq.++ "6" (seq.++ "9" ""))))))))
;witness2: "AZ\x38188"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "Z" (seq.++ "\x03" (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "A" (seq.++ "Z" "")))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
