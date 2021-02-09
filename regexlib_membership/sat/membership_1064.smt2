;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [ ]*=[ ]*[\&quot;]*cid[ ]*:[ ]*([^\&quot;&lt;&gt; ]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "=   ;cid  :\u0098"
(define-fun Witness1 () String (seq.++ "=" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ ";" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ " " (seq.++ " " (seq.++ ":" (seq.++ "\x98" "")))))))))))))
;witness2: " = ;;cid: \u00C9\u0089N"
(define-fun Witness2 () String (seq.++ " " (seq.++ "=" (seq.++ " " (seq.++ ";" (seq.++ ";" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ ":" (seq.++ " " (seq.++ "\xc9" (seq.++ "\x89" (seq.++ "N" ""))))))))))))))

(assert (= regexA (re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (str.to_re (seq.++ "c" (seq.++ "i" (seq.++ "d" ""))))(re.++ (re.* (re.range " " " "))(re.++ (re.range ":" ":")(re.++ (re.* (re.range " " " ")) (re.+ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
