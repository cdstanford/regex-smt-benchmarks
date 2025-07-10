;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href=[\&quot;\']?((?:[^&gt;]|[^\s]|[^&quot;]|[^'])+)[\&quot;\']?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Vhref=;@eA("
(define-fun Witness1 () String (str.++ "V" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ ";" (str.++ "@" (str.++ "e" (str.++ "A" (str.++ "(" ""))))))))))))
;witness2: "_href=o\u00D3"
(define-fun Witness2 () String (str.++ "_" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "o" (str.++ "\u{d3}" "")))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" ""))))))(re.++ (re.opt (re.union (re.range "&" "'")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.+ (re.union (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}")))))(re.union (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))(re.union (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}")))))) (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}")))))) (re.opt (re.union (re.range "&" "'")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
