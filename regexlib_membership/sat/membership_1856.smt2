;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(s-|S-){0,1}[0-9]{3}\s?[0-9]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "097\u008501"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "7" (seq.++ "\x85" (seq.++ "0" (seq.++ "1" "")))))))
;witness2: "s-01789"
(define-fun Witness2 () String (seq.++ "s" (seq.++ "-" (seq.++ "0" (seq.++ "1" (seq.++ "7" (seq.++ "8" (seq.++ "9" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (seq.++ "s" (seq.++ "-" ""))) (str.to_re (seq.++ "S" (seq.++ "-" "")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
