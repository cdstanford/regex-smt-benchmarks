;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href=[\&quot;\']?((?:[^&gt;]|[^\s]|[^&quot;]|[^'])+)[\&quot;\']?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Vhref=;@eA("
(define-fun Witness1 () String (seq.++ "V" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ ";" (seq.++ "@" (seq.++ "e" (seq.++ "A" (seq.++ "(" ""))))))))))))
;witness2: "_href=o\u00D3"
(define-fun Witness2 () String (seq.++ "_" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "o" (seq.++ "\xd3" "")))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" ""))))))(re.++ (re.opt (re.union (re.range "&" "'")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.+ (re.union (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff")))))(re.union (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))(re.union (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff")))))) (re.union (re.range "\x00" "&") (re.range "(" "\xff")))))) (re.opt (re.union (re.range "&" "'")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
