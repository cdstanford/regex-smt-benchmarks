;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((6011)((-|\s)?[0-9]{4}){3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "601131419907\u00855884"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" (seq.++ "3" (seq.++ "1" (seq.++ "4" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "7" (seq.++ "\x85" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "4" ""))))))))))))))))))
;witness2: "601189798376\x93929"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "7" (seq.++ "6" (seq.++ "\x09" (seq.++ "3" (seq.++ "9" (seq.++ "2" (seq.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" ""))))) ((_ re.loop 3 3) (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 4 4) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
