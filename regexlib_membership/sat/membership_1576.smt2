;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <([^<>\s]*)(\s[^<>]*)?>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "b<\u00BAL\u0084>"
(define-fun Witness1 () String (seq.++ "b" (seq.++ "<" (seq.++ "\xba" (seq.++ "L" (seq.++ "\x84" (seq.++ ">" "")))))))
;witness2: "<\x0A:\u009AL\x9\u00BB\u009E>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "\x00" (seq.++ "A" (seq.++ ":" (seq.++ "\x9a" (seq.++ "L" (seq.++ "\x09" (seq.++ "\xbb" (seq.++ "\x9e" (seq.++ ">" "")))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))(re.++ (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.* (re.union (re.range "\x00" ";")(re.union (re.range "=" "=") (re.range "?" "\xff")))))) (re.range ">" ">"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
