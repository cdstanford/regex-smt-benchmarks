;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <\?xml.*</note>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1B.<?xml</note>\x10\xF"
(define-fun Witness1 () String (seq.++ "\x1b" (seq.++ "." (seq.++ "<" (seq.++ "?" (seq.++ "x" (seq.++ "m" (seq.++ "l" (seq.++ "<" (seq.++ "/" (seq.++ "n" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" (seq.++ "\x10" (seq.++ "\x0f" "")))))))))))))))))
;witness2: "]\u0094<?xml\x13O</note>"
(define-fun Witness2 () String (seq.++ "]" (seq.++ "\x94" (seq.++ "<" (seq.++ "?" (seq.++ "x" (seq.++ "m" (seq.++ "l" (seq.++ "\x13" (seq.++ "O" (seq.++ "<" (seq.++ "/" (seq.++ "n" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "?" (seq.++ "x" (seq.++ "m" (seq.++ "l" ""))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "n" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
