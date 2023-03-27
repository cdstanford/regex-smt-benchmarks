;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href[\s]*=[\s]*&quot;[^\n&quot;]*&quot;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E1href=&quot;&quot;!"
(define-fun Witness1 () String (str.++ "\u{e1}" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "!" ""))))))))))))))))))))
;witness2: "href\u00A0 =\u0085\u00A0&quot;&quot;"
(define-fun Witness2 () String (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "\u{a0}" (str.++ " " (str.++ "=" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" "")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}")))))))) (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
