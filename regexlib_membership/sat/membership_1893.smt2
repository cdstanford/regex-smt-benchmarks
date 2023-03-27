;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((mailto\:|(news|(ht|f)tp(s?))\://){1}\S+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ftps://]\x16\u00E4\u00C3\u00A88\u00C0\u00D6\u0082"
(define-fun Witness1 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "]" (str.++ "\u{16}" (str.++ "\u{e4}" (str.++ "\u{c3}" (str.++ "\u{a8}" (str.++ "8" (str.++ "\u{c0}" (str.++ "\u{d6}" (str.++ "\u{82}" "")))))))))))))))))
;witness2: "ftps://}\u00A3\u00D0;5\u00D0"
(define-fun Witness2 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "}" (str.++ "\u{a3}" (str.++ "\u{d0}" (str.++ ";" (str.++ "5" (str.++ "\u{d0}" ""))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "o" (str.++ ":" "")))))))) (re.++ (re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "w" (str.++ "s" ""))))) (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (str.++ "t" (str.++ "p" ""))) (re.opt (re.range "s" "s"))))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))))) (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
