;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((mailto\:|(news|(ht|f)tp(s?))\://){1}\S+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ftps://]\x16\u00E4\u00C3\u00A88\u00C0\u00D6\u0082"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "]" (seq.++ "\x16" (seq.++ "\xe4" (seq.++ "\xc3" (seq.++ "\xa8" (seq.++ "8" (seq.++ "\xc0" (seq.++ "\xd6" (seq.++ "\x82" "")))))))))))))))))
;witness2: "ftps://}\u00A3\u00D0;5\u00D0"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "}" (seq.++ "\xa3" (seq.++ "\xd0" (seq.++ ";" (seq.++ "5" (seq.++ "\xd0" ""))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "l" (seq.++ "t" (seq.++ "o" (seq.++ ":" "")))))))) (re.++ (re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" ""))))) (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (seq.++ "t" (seq.++ "p" ""))) (re.opt (re.range "s" "s"))))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))) (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
