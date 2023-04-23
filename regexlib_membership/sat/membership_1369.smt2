;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href[ ]*=[ ]*('|\&quot;)([^\&quot;'])*('|\&quot;)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "href=\'&quot;\u00A3\x11\u0088\u00A2|"
(define-fun Witness1 () String (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "'" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "\u{a3}" (str.++ "\u{11}" (str.++ "\u{88}" (str.++ "\u{a2}" (str.++ "|" ""))))))))))))))))))
;witness2: "\u00C7;href=      &quot;\u007F\u00BF\x4&quot;\u00D5"
(define-fun Witness2 () String (str.++ "\u{c7}" (str.++ ";" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "\u{7f}" (str.++ "\u{bf}" (str.++ "\u{04}" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "\u{d5}" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" "")))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.range "'" "'") (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "(" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}"))))))) (re.union (re.range "'" "'") (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
