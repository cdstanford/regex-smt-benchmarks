;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [ ]*=[ ]*[\&quot;]*cid[ ]*:[ ]*([^\&quot;&lt;&gt; ]+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "=   ;cid  :\u0098"
(define-fun Witness1 () String (str.++ "=" (str.++ " " (str.++ " " (str.++ " " (str.++ ";" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ " " (str.++ " " (str.++ ":" (str.++ "\u{98}" "")))))))))))))
;witness2: " = ;;cid: \u00C9\u0089N"
(define-fun Witness2 () String (str.++ " " (str.++ "=" (str.++ " " (str.++ ";" (str.++ ";" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ ":" (str.++ " " (str.++ "\u{c9}" (str.++ "\u{89}" (str.++ "N" ""))))))))))))))

(assert (= regexA (re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (str.to_re (str.++ "c" (str.++ "i" (str.++ "d" ""))))(re.++ (re.* (re.range " " " "))(re.++ (re.range ":" ":")(re.++ (re.* (re.range " " " ")) (re.+ (re.union (re.range "\u{00}" "\u{1f}")(re.union (re.range "!" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
