;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{1,2}(\:|\s)\d{1,2}(\:|\s)\d{1,2}\s*(AM|PM|A|P))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A8\u00AB\u00990 8 88\u00A0P\u00DD"
(define-fun Witness1 () String (seq.++ "\xa8" (seq.++ "\xab" (seq.++ "\x99" (seq.++ "0" (seq.++ " " (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "\xa0" (seq.++ "P" (seq.++ "\xdd" "")))))))))))))
;witness2: "\u00BF8\u00A04\u008598\u0085\u0085\xBPM\u00D8\x2\u00F1\u00B0"
(define-fun Witness2 () String (seq.++ "\xbf" (seq.++ "8" (seq.++ "\xa0" (seq.++ "4" (seq.++ "\x85" (seq.++ "9" (seq.++ "8" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\x0b" (seq.++ "P" (seq.++ "M" (seq.++ "\xd8" (seq.++ "\x02" (seq.++ "\xf1" (seq.++ "\xb0" "")))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range ":" ":")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range ":" ":")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" ""))) (re.union (re.range "A" "A") (re.range "P" "P"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
