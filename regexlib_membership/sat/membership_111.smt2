;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{4}\s\d{4}\s\d{4}\s\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "7\x1A9890\u00858515\xC8484\u00850782"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "\x1a" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "\x85" (seq.++ "8" (seq.++ "5" (seq.++ "1" (seq.++ "5" (seq.++ "\x0c" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "4" (seq.++ "\x85" (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "2" ""))))))))))))))))))))))
;witness2: "3348\xA8909\u00A00920 9467"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "3" (seq.++ "4" (seq.++ "8" (seq.++ "\x0a" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "9" (seq.++ "\xa0" (seq.++ "0" (seq.++ "9" (seq.++ "2" (seq.++ "0" (seq.++ " " (seq.++ "9" (seq.++ "4" (seq.++ "6" (seq.++ "7" ""))))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
